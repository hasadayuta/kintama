class Context
  attr_reader :name

  def initialize(name, parent=nil, &block)
    @name = name
    @block = block
    @subcontexts = {}
    @tests = {}
    @parent = parent
    instance_eval(&@block)
  end

  def run(runner=nil)
    runner.started(self) if runner
    all_tests.each { |t| t.run(runner) }
    all_subcontexts.each { |s| s.run(runner) }
  end

  def context(name, &block)
    @subcontexts[methodize(name)] = self.class.new(name, self, &block)
  end

  def setup(&setup_block)
    @setup_block = setup_block
  end

  def run_setups(environment)
    @parent.run_setups(environment) if @parent
    environment.instance_eval(&@setup_block) if @setup_block
  end

  def should(name, &block)
    full_name = "should " + name
    @tests[methodize(full_name)] = Test.new(full_name, self, &block)
  end

  def passed?
    failures.empty? && all_subcontexts.inject(true) { |result, s| result && s.passed? }
  end

  def failures
    all_tests.select { |t| !t.passed? }
  end

  def method_missing(name, *args)
    @subcontexts[name] || @tests[name]
  end

  class Test
    attr_accessor :name, :failure

    def initialize(name, context, &block)
      @name = name
      @context = context
      @test_block = block
      @failure = nil
    end

    def run(runner=nil)
      runner.started(self) if runner
      environment = TestEnvironment.new(self)
      @context.run_setups(environment)
      environment.instance_eval(&@test_block)
      runner.finished(self) if runner
    end

    def passed?
      @failure.nil?
    end
  end

  class TestEnvironment
    def initialize(test)
      @test = test
    end

    def assert(expression, message="failed")
      unless expression
        @test.failure = message
      end
    end

    def assert_equal(expected, actual)
      assert actual == expected, "Expected #{expected.inspect} but got #{actual.inspect}"
    end
  end

  private

  def methodize(name)
    name.gsub(" ", "_").to_sym
  end

  def all_subcontexts
    @subcontexts.values
  end

  def all_tests
    @tests.values
  end

end
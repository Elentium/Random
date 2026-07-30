const TestService = game:GetService("TestService")
const Random = require(".") -- adjust path as needed
const Bench = require("@self/Bench")
const Types = require("@self/Types")

type BenchResult = Types.BenchResult
type SectionNode = Types.SectionNode
type RunResult = Types.RunResult

const RunResult: RunResult = {}
local CurrentSection: string = ""

const HeaderFString = [=[
[[ BENCHMARK RESULTS ]]
• IterationCount: %d
-----------------------
]=]
const Divider = ("-"):rep(30)
const SectionFString = '----- SECTION: "%s"'
const TestResultFString = [=[
[[----- %s -----]]
• min avg μs: %f
• med avg μs: %f
• avg avg μs: %f
• max avg μs: %f
[[--------------]]
]=]

const function Section(Name: string)
	RunResult[Name] = {}
	CurrentSection = Name
end

const function PrintResults(iterationCount: number)
	TestService:Message(HeaderFString:format(iterationCount))
	for sectionName: string, node: SectionNode in RunResult do
		TestService:Message(Divider)
		TestService:Message(SectionFString:format(sectionName))
		TestService:Message(Divider)
		for testName: string, result: BenchResult in node do
			TestService:Message(
				TestResultFString:format(
					testName,
					result.min.AvgUs,
					result.med.AvgUs,
					result.avg.AvgUs,
					result.max.AvgUs
				)
			)
		end
		TestService:Message(Divider)
	end
end

const function Test(name: string, func: () -> (), iterationCount: number)
	const BenchResult = Bench(func, iterationCount)
	RunResult[CurrentSection][name] = BenchResult
end

const function RunBenchmark(iterationCount: number, log: boolean?)
	do
		const Rng = Random.new()
		const range = { min = 1, max = 10 }
		const frange = { min = 0, max = 1 }

		Section("Random – Primitives")

		Test("Integer", function()
			Rng:Integer(1, 1e3)
		end, iterationCount)

		Test("Float", function()
			Rng:Float(1, 3.14)
		end, iterationCount)

		Section("Random – Roblox Types")

		Test("Vector3", function()
			Rng:Vector3(range, range, range)
		end, iterationCount)

		Test("Vector2", function()
			Rng:Vector2(range, range)
		end, iterationCount)

		Test("Color3", function()
			Rng:Color3()
		end, iterationCount)

		Test("UDim2", function()
			Rng:UDim2(range, range)
		end, iterationCount)

		Test("UDim2Scaled", function()
			Rng:UDim2Scaled(frange, frange)
		end, iterationCount)

		Test("CFrame", function()
			Rng:CFrame({ x = range, y = range, z = range }, "XYZ")
		end, iterationCount)

		Test("UnitVector", function()
			Rng:UnitVector()
		end, iterationCount)

		Section("Random – Choice API")

		const ChoiceDict = { a = 1, b = 2, c = 3, d = 4, e = 5, f = 6, g = 7 }
		Test(":Choice", function()
			Rng:Choice(ChoiceDict)
		end, iterationCount)

		const WeightedChoiceContainer = {
			{ weight = 60, item = "hi" },
			{ weight = 30, item = "bye" },
			{ weight = 9, item = "noo" },
			{ weight = 1, item = "omg" },
		}
		Test(":WeightedChoice", function()
			Rng:WeightedChoice(WeightedChoiceContainer, 100)
		end, iterationCount)

		Test(":ChooseMultiple (5 items; no duplicate)", function()
			Rng:ChooseMultiple(ChoiceDict, 5, nil, false)
		end, iterationCount)

		Test(":ChooseMultiple (5 items; allow duplicate)", function()
			Rng:ChooseMultiple(ChoiceDict, 5, nil, true)
		end, iterationCount)

		const Array = table.create(100, 0)
		Test(":BlazeChoice", function()
			Rng:BlazeChoice(Array)
		end, iterationCount)
	end
	if log then
		PrintResults(iterationCount)
	end
end

return RunBenchmark

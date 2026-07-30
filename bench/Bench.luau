const Types = require("./Types")

type BenchResult = Types.BenchResult
type BenchNode = Types.BenchNode

const function GetResult(t: number, iterationCount: number): BenchNode
	const totalMs = t * 1_000
	const totalUs = totalMs * 1_000
	const totalNs = totalUs * 1_000
	const avgUs = totalUs / iterationCount
	const avgNs = totalNs / iterationCount

	return {
		TotalMs = totalMs,
		TotalUs = totalUs,
		TotalNs = totalNs,
		AvgUs = avgUs,
		AvgNs = avgNs,
	}
end

const function Bench(func: () -> (), iterationCount: number): BenchResult
	local overhead
	do
		local function empty() end
		const start = os.clock()
		for _ = 1, iterationCount do
			empty()
		end
		overhead = os.clock() - start
	end

	-- warm up
	for _ = 1, 100 do
		func()
	end

	const results = table.create<<number>>(5)
	local min, max, sum = math.huge, 0, 0
	for i = 1, 5 do
		const start = os.clock()
		for _ = 1, iterationCount do
			func()
		end
		const result = math.max(0, (os.clock() - start) - overhead)

		if result < min then
			min = result
		end
		if result > max then
			max = result
		end
		sum += result
		results[i] = result
	end

	table.sort(results)
	const med = results[3]
	const avg = sum / 5

	const benchResult = {}
	benchResult.min = GetResult(min, iterationCount)
	benchResult.max = GetResult(max, iterationCount)
	benchResult.med = GetResult(med, iterationCount)
	benchResult.avg = GetResult(avg, iterationCount)

	return benchResult
end

return Bench

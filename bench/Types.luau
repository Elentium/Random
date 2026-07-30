export type BenchNode = {
	TotalMs: number, -- total in milliseconds
	TotalUs: number, -- total in microseconds
	AvgUs: number, -- avg in microseconds
	TotalNs: number, -- total in nanoseconds
	AvgNs: number, -- avg in nanoseconds
}
export type BenchResult = {
	min: BenchNode,
	max: BenchNode,
	med: BenchNode,
	avg: BenchNode,
}

export type SectionNode = {
	[string]: BenchResult,
}

export type RunResult = {
	[string]: SectionNode,
}

return nil

package metrics

// IncrCounter patches https://github.com/armon/go-metrics/blob/8ca742bd545671bedae063d0672cb3c8da7d4437/metrics.go#L59
func IncrCounter(key []string, val float32) {
}

def range(start, ending)
  return start if start == ending
  arr = [start]
  arr << range(start + 1, ending)
  arr.flatten
end

def sum_recurs(arr)
  return arr.first if arr.length == 1
  arr.pop + sum_recurs(arr)
end

def sum_iter(arr)
  arr.inject(&:+)
end

def expo_recursion_1(num, pow)
  return 1 if pow == 0
  num * expo_recursion_1(num, pow - 1)
end

def expo_recursion_2(num, pow)
  return 1 if pow == 0
  return num if pow == 1

  if pow.even?
    expo_recursion_2(num, pow/2) ** 2
  else
    num * ( expo_recursion_2(num, (pow-1)/2) ** 2 )
  end
end

def deep_dup(arr)
  return arr.dup if arr.none? { |el| el.is_a?(Array)}
  deep_arr = []
  arr.each do |el|
    deep_arr << el if el.is_a?(Fixnum)
    deep_arr << deep_dup(el) if el.is_a?(Array)
  end

  deep_arr
end

def fibonacci(n)
  return [1, 1] if n <= 2
  arr = []
  n_one_before = fibonacci(n-1)
  arr << n_one_before
  arr << (n_one_before[-1] + n_one_before[-2])
  arr.flatten
end

def b_search(arr, target)
  middle_idx = arr.length/2
  middle_num = arr[middle_idx]
  return middle_idx if target == middle_num
  if middle_num < target
    return b_search(arr[middle_idx + 1.. -1], target) + middle_idx + 1
  else
    return b_search(arr[0 ... middle_idx], target)
  end
end

def merge_sort(arr)
  return arr if arr.length == 1
  middle_idx = arr.length/2
  first_half = merge_sort(arr[0...middle_idx])
  second_half = merge_sort(arr[middle_idx..-1])
  merge_arrays(first_half, second_half)
end

def merge_arrays(arr1, arr2)
  merged_arr = []
  until arr1.empty? && arr2.empty?
    if arr1.empty?
      merged_arr << arr2.shift
    elsif arr2.empty?
      merged_arr << arr1.shift
    elsif arr1.first <= arr2.first
      merged_arr << arr1.shift
    else
      merged_arr << arr2.shift
    end
  end
  merged_arr
end

def subset(arr)
  return [arr] if arr.length == 0
  last_el = [arr.pop]
  prev_subsets = subset(arr)
  curr_subsets = prev_subsets.dup
  prev_subsets.each { |el| curr_subsets << (el + last_el) }
  curr_subsets
end

def greedy_make_change(total, coins)
  return [] if total == 0
  coin = coins.shift
  change = []
  while change.inject(0, &:+) <= total - coin
    change << coin
  end
  total -= change.inject(0, &:+)
  change << greedy_make_change(total, coins)
  change.flatten
end

def make_better_change(total, coins)
  return [] if total == 0
  change = []
  min_turns = get_turns(total, coins.min)
  min_idx = coins.find_index(coins.min)
  coins.each_with_index do |coin, idx|
    next if coin > total
    if get_turns(total, coin) < min_turns
      min_turns = get_turns(total, coin)
      min_idx = idx
    end
  end
  change << coins[min_idx]
  change << make_better_change(total - coins[min_idx], coins)
  change.flatten.sort.reverse
end

def get_turns(total, coin)
  total / coin + total % coin
end

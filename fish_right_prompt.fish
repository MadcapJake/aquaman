
function aqua_git_is_stashed
  command git rev-parse --verify --quiet refs/stash >/dev/null
end

function aqua_git_branch_name
  command git symbolic-ref --short HEAD
end

function aqua_git_is_touched
  test -n (echo (command git status --porcelain))
end

function fish_right_prompt
  set -l code $status

  function status::color -S
    test $code -ne 0; and echo (aqua_snd); or echo (aqua_fst)
  end

  if test $CMD_DURATION -gt 1000
    printf (aqua_dim)" ~"(printf "%.1fs " (math "$CMD_DURATION / 1000"))(aqua_off)
  end

  if test -d .git
    if aqua_git_is_stashed
      echo (aqua_dim)"<"(aqua_off)
    end
    printf (begin
      aqua_git_is_touched
        and echo (aqua_snd)"《"(aqua_fth)"*"(aqua_fst)(aqua_git_branch_name)(aqua_snd)" 》"(aqua_off)
        or echo (aqua_snd)"《 "(aqua_fst)(aqua_git_branch_name)(aqua_snd)" 》"(aqua_off)
    end)(aqua_off)
  end

  printf " "(aqua_dim)(date +%H(status::color):(aqua_dim)%M(status::color):(aqua_dim)%S)(aqua_snd)" "(aqua_off)

  if test $code -ne 0
    echo (aqua_fst)"⚠ "(aqua_trd)"$code"(aqua_off)
  end
end

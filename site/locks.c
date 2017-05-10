#include <tesla-macros.h>

#include <stdatomic.h>
#include <stdbool.h>
#include <stdlib.h>

// Forward declarations
struct lock;
bool lock_acquire(struct lock *l);
void lock_release(struct lock *l);
int main(void);

struct lock {
  _Atomic(bool) held;
};

bool lock_acquire(struct lock *l)
{
  TESLA_WITHIN(main, eventually(
    call(lock_release(l))
  ));

  bool f = false;
  return atomic_compare_exchange_strong(&(l->held), &f, true);
}

void lock_release(struct lock *l)
{
  l->held = false;
}

int main(void)
{
  struct lock *l = malloc(sizeof(*l));

  lock_acquire(l);
  lock_release(l);
  
  return 0;
}

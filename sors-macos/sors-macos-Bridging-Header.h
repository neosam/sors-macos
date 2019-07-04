//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

struct DocCarry;
typedef struct DocCarry DocCarry;

struct Uuid;
typedef struct Uuid Uuid;

struct RcTask;
typedef struct RcTask RcTask;

void sors_free_string(char *string);

DocCarry *sors_doc_new(void);
DocCarry *sors_doc_load(const char *path);

void sors_doc_free(DocCarry *);
void sors_id_free(Uuid *);
void sors_task_free(RcTask *);

Uuid *sors_doc_root_id(DocCarry *);
RcTask *sors_doc_get_task(DocCarry *, Uuid *);
char *sors_task_title(RcTask *);
char *sors_task_body(RcTask *);

int sors_task_children_count(RcTask *);
Uuid *sors_task_children_get(RcTask *, int);
DocCarry *sors_doc_update_task_title(DocCarry *, Uuid *, const char *);
DocCarry *sors_doc_update_task_body(DocCarry *, Uuid *, const char *);


#include<stdio.h>
#include<gtk/gtk.h>
#include<glib.h>

int main(int argc, char* argv[])
{
  gsize x,y;
  GError *error=NULL;

  gtk_init(&argc ,&argv);
  //  g_type_init ();
  //  printf("%d\n",g_type_from_name("GTK_TYPE_STRING"));
  // printf("%p\n",g_type_fundamental_next());
  
  printf("result:%s",g_convert("abcdd",5,"Latin-1","UTF-8",&x,&y,&error));
  
  exit(0);
}

// gcc `pkg-config --libs --cflags gtk+-2.0` main.c

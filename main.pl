use lib::Flag;

Flag::var("n", "zhangsan", "user name");

%param = Flag::parse(@ARGV);

while(($index, $value) = each %param) {
  print $value;
}

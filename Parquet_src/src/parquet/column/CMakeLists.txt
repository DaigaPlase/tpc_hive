# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

# Headers: top level
install(FILES
  levels.h
  page.h
  properties.h
  reader.h
  scan-all.h
  scanner.h
  writer.h
  statistics.h
  DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/parquet/column")

ADD_PARQUET_TEST(column-reader-test)
ADD_PARQUET_TEST(column-writer-test)
ADD_PARQUET_TEST(levels-test)
ADD_PARQUET_TEST(properties-test)
ADD_PARQUET_TEST(scanner-test)
ADD_PARQUET_TEST(statistics-test)

ADD_PARQUET_BENCHMARK(column-io-benchmark)
ADD_PARQUET_BENCHMARK(level-benchmark)

import org.junit.Test;
import scythe_interface.ExampleDS;
import sql.lang.Table;

import java.io.File;
import java.io.IOException;

/**
 * Created by clwang on 11/4/16.
 */
public class StatsCollector {
    @Test
    public void calculate() {
        String path = "data/sqlsynthesizer/";

        File dir = new File(path);
        File[] directoryListing = dir.listFiles();
        int totalCount = 0;
        int sumSize = 0;
        int maxSize = 0;
        int minSize = 9999;

        int const1 = 0;
        int const2 = 0;
        int const3 = 0;
        int big3 = 0;

        if (directoryListing != null) {
            for (File child : directoryListing) {

                if (child.toString().contains("R")) continue;

                ExampleDS ds = null;

                if (child.isDirectory()) continue;
                ds = ExampleDS.readFromFile(child.getPath());

                if (ds != null) {
                    if (ds.inputs == null || ds.output == null || ds.enumConfig == null) continue;

                    if (ds.enumConfig.getConstValues().size() == 1) const1 ++;
                    if (ds.enumConfig.getConstValues().size() == 2) const2 ++;
                    if (ds.enumConfig.getConstValues().size() == 3) const3 ++;
                    if (ds.enumConfig.getConstValues().size() > 3) big3 ++;

                    int size = 0;
                    for (Table t : ds.inputs) {
                        size += t.getContent().size() * t.getContent().get(0).getValues().size();
                    }
                    totalCount += 1;
                    size += ds.output.getContent().size() * ds.output.getContent().get(0).getValues().size();
                    System.out.println(child.getPath());

                    size += ds.enumConfig.getConstValues() == null ? 0 : ds.enumConfig.getConstValues().size();

                    System.out.println("[size]" + size);
                    sumSize += size;
                    minSize = minSize > size ? size : minSize;
                    maxSize = maxSize < size ? size : maxSize;

                }
            }
            System.out.println("[avg size] " + ((double) sumSize) / totalCount);
            System.out.println("[cnt] " + totalCount);
            System.out.println("[max] " + maxSize);
            System.out.println("[min] " + minSize);

            System.out.println("[cont123] " + const1 + " " + const2 + " " + const3 + "  " + big3);

        } else {
            // Handle the case where dir is not really a directory.
            // Checking dir.isDirectory() above would not be sufficient
            // to avoid race conditions with another process that deletes
            // directories.
        }
    }
}

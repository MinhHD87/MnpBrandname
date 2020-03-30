/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.utils;

import gk.myname.vn.config.MyContext;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import javax.imageio.ImageIO;
import net.coobird.thumbnailator.Thumbnails;

/**
 *
 * @author PLATUAN
 */
public class FileUtils {

    /**
     *
     * @param arrbyte
     * @param full_path
     * @return
     */
    public static boolean writeFileToDisk(byte[] arrbyte, String full_path) {
        boolean flag = false;
        FileOutputStream fsave = null;
        try {
            File f = new File(full_path);
            if (!f.exists()) {
                f.createNewFile();
            }
            fsave = new FileOutputStream(f);
            fsave.write(arrbyte);
            flag = true;
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                fsave.flush();
                fsave.close();
            } catch (IOException ex) {
                System.out.println("Loi dong Ouput Stream");
            }
            return flag;
        }
    }
    private static final int bufferSize = 8192;

    public static void copy(InputStream in, OutputStream out) throws IOException {
        byte[] buffer = new byte[bufferSize];
        int read;

        while ((read = in.read(buffer, 0, bufferSize)) != -1) {
            out.write(buffer, 0, read);
        }
    }

    /**
     *
     * @param bis
     * @return
     */
    public static byte[] writeBuffer2Byte(BufferedInputStream bis) {
        byte[] byteReturn = null;
        byte[] buffer = new byte[1024];
        long fileSize = 0;
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try {
            while (true) {
                int iBytes = bis.read(buffer);
                ////System.out.println(iBytes);
                // If there was nothing read, get out of loop
                if (iBytes == -1) {
                    break;
                } else {
                    fileSize += iBytes;
                }
                baos.write(buffer, 0, iBytes);
            }
            byteReturn = baos.toByteArray();
        } catch (IOException ie) {
            ie.printStackTrace();
        } finally {
            try {
                baos.flush();
                baos.close();
                bis.close();
            } catch (Exception e) {
            }
            return byteReturn;
        }
    }

    public static boolean writeContent(BufferedInputStream bis, ByteArrayOutputStream baos) {
        boolean flag = true;
        byte[] buffer = new byte[1024];
        long fileSize = 0;
        try {
            while (true) {
                int iBytes = bis.read(buffer);
                ////System.out.println(iBytes);
                // If there was nothing read, get out of loop
                if (iBytes == -1) {
                    break;
                } else {
                    fileSize += iBytes;
                }
                baos.write(buffer, 0, iBytes);
            }
            if (fileSize > MyContext.MAX_FILE_SIZE) {
                flag = false;
            } else {
                flag = true;
            }
        } catch (IOException ie) {
            ie.printStackTrace();
            flag = false;
        } finally {
            try {
                baos.flush();
                baos.close();
                bis.close();
            } catch (Exception e) {
            }
            return flag;
        }
    }

    public static byte[] getBytesFromFile(File file) throws IOException, FileNotFoundException {
        InputStream fin = new FileInputStream(file);
        // Get the size of the file
        long length = file.length();
        if (length > Integer.MAX_VALUE) {
            throw new IOException("File is too large" + file.getName());
            // File is too large
        }
        // Create the byte array to hold the data
        byte[] bytes = new byte[(int) length];
        // Read in the bytes
        int offset = 0;
        int numRead = 0;
        while (offset < bytes.length && (numRead = fin.read(bytes, offset, bytes.length - offset)) >= 0) {
            offset += numRead;
        }
        // Ensure all the bytes have been read in
        if (offset < bytes.length) {
            throw new IOException("Could not completely read file " + file.getName());
        }
        // Close the input stream and return bytes
        fin.close();
        return bytes;
    }

//    public static BufferedImage resizeImage(BufferedImage originalImage, int type, int image_with) {
//        float IMG_HEIGHT = originalImage.getHeight() / ((float) originalImage.getWidth() / image_with);
//        BufferedImage resizedImage = new BufferedImage(image_with, (int) IMG_HEIGHT, type);
//        Graphics2D graphics2D = resizedImage.createGraphics();
//        graphics2D.setRenderingHint(RenderingHints.KEY_INTERPOLATION,
//                RenderingHints.VALUE_INTERPOLATION_BILINEAR);
//        graphics2D.drawImage(originalImage, 0, 0, image_with, (int) IMG_HEIGHT, null);
//        graphics2D.dispose();
//        return resizedImage;
//    }
//    public static void resizeAndWriteImage(InputStream ipst, int width, String realPath, String extention) {
//        try {
//            BufferedImage originalImage = null;
//            BufferedImage resizeImage = null;
//            originalImage = ImageIO.read(ipst);
//            int type = originalImage.getType() == 0 ? BufferedImage.TYPE_INT_RGB : originalImage.getType();
//            if (extention.startsWith(".")) {
//                extention = extention.substring(1);
//            }
//            //----------------
//            resizeImage = resizeImage(originalImage, type, width);
//            // Den buoc nay ma Write la ok
//            ImageIO.write(resizeImage, extention, new File(realPath));
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//    public static void resize_MaxWith_write(InputStream ipst, int max_width, String realPath, String extention) {
//        try {
//            BufferedImage originalImage = null;
//            BufferedImage resizeImage = null;
//            originalImage = ImageIO.read(ipst);
//            int type = originalImage.getType() == 0 ? BufferedImage.TYPE_INT_RGB : originalImage.getType();
//            //----------------
//            if (originalImage.getWidth() > max_width) {
//                // resize va write
//                resizeImage = resizeImage(originalImage, type, max_width);
//
//            } else {
//                resizeImage = originalImage;
//            }
//            if (extention.startsWith(".")) {
//                extention = extention.substring(1);
//            }
//            ImageIO.write(resizeImage, extention, new File(realPath));
//            // Den buoc nay ma Write la ok
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
    public static void resizeMaxWithWriteImg(InputStream ipst, int max_width, String realPath, String extention) {
        try {
            BufferedImage originalImage = ImageIO.read(ipst);
            //----------------
            if (originalImage.getWidth() > max_width) {
                // resize va write
                Thumbnails.of(originalImage)
                        .width(max_width)
                        .outputFormat(extention)
                        .outputQuality(1)
                        .toFile(new File(realPath));
            } else {
                Thumbnails.of(originalImage)
                        .width(originalImage.getWidth())
                        .outputFormat(extention)
                        .outputQuality(1)
                        .toFile(new File(realPath));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void resizeMaxWithWriteImg(URL url, int max_width, String realPath, String extention) {
        try {
            BufferedImage originalImage = ImageIO.read(url.openStream());
            //----------------
            if (originalImage.getWidth() > max_width) {
                // resize va write
                Thumbnails.of(url)
                        .width(max_width)
                        .outputQuality(1)
                        // .outputFormat(extention)
                        .toFile(new File(realPath));
            } else {
                Thumbnails.of(url)
                        .width(originalImage.getWidth())
                        .outputFormat(extention)
                        .outputQuality(1)
                        .toFile(new File(realPath));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static boolean writeImg(InputStream ipst, String realPath, String extention) {
        try {
            BufferedImage originalImage = ImageIO.read(ipst);
            Thumbnails.of(originalImage)
                    .width(originalImage.getWidth())
                    .outputFormat(extention)
                    .outputQuality(1)
                    .toFile(new File(realPath));
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void writeImg(URL url, String realPath, String extention) {
        try {
            BufferedImage originalImage = ImageIO.read(url.openStream());
            Thumbnails.of(url)
                    .width(originalImage.getWidth())
                    .outputQuality(1)
                    .toFile(new File(realPath));

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void resizeWriteImg(InputStream ips, int width, String realPath, String extention) {
        try {
            // resize va write
            Thumbnails.of(ips)
                    .width(width)
                    .outputFormat(extention)
                    .outputQuality(1)
                    .toFile(new File(realPath));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void resizeWriteImg(URL url, int width, String realPath, String extention) {
        try {
            //----------------
            // resize va write
            Thumbnails.of(url)
                    .width(width)
                    // .outputFormat(extention)
                    .outputQuality(1)
                    .toFile(new File(realPath));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

From: Niklas Werner <bergtroll@gmx.li>
Subject: EMI 2|6 in Soundcard-matrix (again)
Date: Thu, 8 May 2003 11:47:49 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305081147.49126.bergtroll@gmx.li>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hallo list!

once again... (maybe it gets added this time)

You might add Emagic's EMI 2|6 to the matrix:

Using the Kernel-module emi26 (present in stock-kernels as of 2.4.19, 
IIRC) as firmware-loader it runs just fine with alsa's usb-audio-driver.

-ac3-5.1 out works
-2-in/2-out using 24/96 as well
-oss works as well, though only in stereo
-works on PPC as well as on intel!

http://www.emagic.de/products/hw/emi26/index.php?lang=EN

have fun*

Niklas


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

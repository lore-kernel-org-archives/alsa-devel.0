From: plessas@mur.at (Peter Plessas)
Subject: hg configure no soundcard all
Date: Thu, 7 Sep 2006 00:46:18 +0200
Message-ID: <20060906224618.GA8250@mur.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dear List.

Wanting to compile the drivers from the hg repository, but being stuck
at running ./configure which ends with:

	checking for which soundcards to compile driver for... configure: error:
	Unknown soundcard all

when i specify a single card i get about the same error:

	...
	Unknown soundcard hdsp

This must be something really simple, but i don't really get the
solution.

If anyone has an idea, i'd be glad to know!

Please CC: me, as i am not permamently on the list.

regards,

Peter

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

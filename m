From: Lee Revell <rlrevell@joe-job.com>
Subject: compile warnings with latest cvs
Date: Tue, 10 Aug 2004 11:53:52 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1092153232.10794.3.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

In file included from
/home/rlrevell/cvs/alsa/alsa-driver/acore/sound.c:30:
/home/rlrevell/cvs/alsa/alsa-driver/include/sound/version.h:2:1:
warning: "CONFIG_SND_VERSION" redefined
In file included from
/home/rlrevell/cvs/alsa/alsa-driver/include/sound/driver.h:26,
                 from
/home/rlrevell/cvs/alsa/alsa-driver/acore/sound.c:22:
/home/rlrevell/cvs/alsa/alsa-driver/include/config.h:9:1: warning: this
is the location of the previous definition

Lee



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285

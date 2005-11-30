From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [ANNOUNCE] ASoC 0.8
Date: Wed, 30 Nov 2005 22:50:55 +0000
Message-ID: <1133391055.3314.175.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from orlando.wolfsonmicro.main (webmail.wolfsonmicro.com [212.20.225.142])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 58DDD17A
	for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2005 23:50:49 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ALSA SoC Layer 0.8 has now been released and is available here
http://www.rpsys.net/openzaurus/patches/alsa/.

Changes from 0.7:-

  o ASoC is now a bus interface. Allows easier codec matching.
  o Moved all control (i2c) code out of code drivers.
  o Fixed OSS emulation bug (e.g. madplayer)
  o Added PM for pxa2xx platform
  o Machine level kcontrols
  o Machine level DPM widgets.
  o Added support for Corgi and Tosa PDA's

More information about ASoC is available here
http://www.rpsys.net/openzaurus/patches/alsa/asoc.html

Liam



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

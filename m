From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000559]: 64 Bit Drivers for Analog Devices SoundMax
Date: Sat,  2 Oct 2004 15:08:59 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041002130859.4A78F3200A@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AF416242
	for <alsa-devel@alsa-project.org>; Sat,  2 Oct 2004 15:08:59 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000559
======================================================================
Reported By:                sandy bodell
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     559
Category:                   OTHERS
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Suse
Kernel Version:             2.6.5-7.108
======================================================================
Date Submitted:             10-02-2004 13:46 CEST
Last Modified:              10-02-2004 15:08 CEST
======================================================================
Summary:                    64 Bit Drivers for Analog Devices SoundMax
Description: 
Are there any 64 bit drivers available anywhere for this chipset?

Thanks
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 10-02-2004 15:08 CEST 
----------------------------------------------------------------------
When compiled with a 64 bit kernel, the drivers are 64 bit, too.

The driver for your device is snd-intel8x0 or snd-via82xx or snd-atiixp,
depending on your chipset.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-02-04 13:46 sandy bodell   New Bug                                      
10-02-04 13:46 sandy bodell   Distribution              => Suse            
10-02-04 13:46 sandy bodell   Kernel Version            => 2.6.5-7.108     
10-02-04 15:08 Clemens LadischBugnote Added: 0002006                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl

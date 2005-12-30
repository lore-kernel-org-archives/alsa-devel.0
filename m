From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000763]: I can't make the emulation of /dev/dsp work;  the driver "executes" but reports errors;  there is no sound output.
Date: Fri, 30 Dec 2005 23:03:06 +0100
Message-ID: <deb6e7fd6a90e0e5660b194ab69bd450@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4F42818F
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 23:03:06 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=763> 
======================================================================
Reported By:                lovett
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   763
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             12-30-2004 22:48 CET
Last Modified:              12-30-2005 23:03 CET
======================================================================
Summary:                    I can't make the emulation of /dev/dsp work;  the
driver "executes" but reports errors;  there is no sound output.
Description: 
I have a "Sound Blaster" card.  /proc/asound/cards says:
0 [Live           ]: EMU10K1 - Sound Blaster Live!
                     Sound Blaster Live! (rev.8, serial:0x80641102) at
0x8c00, irq 23
======================================================================

----------------------------------------------------------------------
 jdthood - 09-14-05 16:22 
----------------------------------------------------------------------
Submitter: Did you ever manage to solve this problem?

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:03 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-30-04 22:48 lovett         New Issue                                    
01-03-05 12:05 tiwai          Note Added: 0003052                          
01-03-05 18:12 lovett         File Added: dspFailure                       
01-03-05 23:35 lovett         Note Added: 0003076                          
01-14-05 17:25 lovett         Note Added: 0003208                          
09-14-05 16:22 jdthood        Note Added: 0006183                          
12-30-05 23:03 rlrevell       Status                   new => closed       
12-30-05 23:03 rlrevell       Note Added: 0007274                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

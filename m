From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000504]: after the alsa modules are loaded, active speaker beginns to make noise
Date: Fri, 30 Dec 2005 23:03:54 +0100
Message-ID: <9e56513ed979fd336470a8bffd8b338b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0966B18F
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 23:03:55 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=504> 
======================================================================
Reported By:                placew
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   504
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Gentoo.2004
Kernel Version:             2.6.7-gentoo-r6
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             09-16-2004 12:36 CEST
Last Modified:              12-30-2005 23:03 CET
======================================================================
Summary:                    after the alsa modules are loaded, active speaker
beginns to make noise
Description: 
i've got my alsa modules compiled in a kernel, v.2.6.7-gentoo-r6. At boot,
once, there are the alsa modules loaded, active speaker starts hissing.
When mp3 (or other sound) is playing, the noise is getting low, almoust
unhearable. Active speaker stops hissing once the modules are unloaded
during the reboot.  My soundcard is ensoniq PCI128, using module ens1371.
Thanks for cooperation.
======================================================================

----------------------------------------------------------------------
 jdthood - 09-14-05 16:21 
----------------------------------------------------------------------
Is the behavior improved in more recent ALSA versions?

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:03 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-16-04 12:36 placew         New Issue                                    
09-16-04 12:36 placew         Distribution              => Gentoo.2004     
09-16-04 12:36 placew         Kernel Version            => 2.6.7-gentoo-r6 
09-17-04 10:42 placew         Issue Monitored: placew                      
09-17-04 10:42 placew         Issue End Monitor: placew                    
09-28-04 16:07 djtm           Note Added: 0001948                          
12-02-04 21:01 Sebastian      Issue Monitored: Sebastian                    
12-02-04 21:12 Sebastian      Note Added: 0002698                          
01-12-05 21:48 wvd            Note Added: 0003179                          
01-12-05 21:50 wvd            Issue Monitored: wvd                         
09-14-05 16:21 jdthood        Note Added: 0006182                          
12-30-05 23:03 rlrevell       Status                   new => closed       
12-30-05 23:03 rlrevell       Note Added: 0007275                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

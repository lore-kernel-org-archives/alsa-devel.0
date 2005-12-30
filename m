From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000200]: White noise when sound driver is loaded
Date: Fri, 30 Dec 2005 05:14:00 +0100
Message-ID: <7d0b78e4f2fb47b5880c44d949ab1e21@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3B795193
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 05:14:00 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=200> 
======================================================================
Reported By:                mbribeiro
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   200
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               gentoo-linux
Kernel Version:             2.6.5
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             04-11-2004 19:55 CEST
Last Modified:              12-30-2005 05:13 CET
======================================================================
Summary:                    White noise when sound driver is loaded
Description: 
Since kernel 2.6.3 I started to have problem with sound. In 2.6.3 sound
stoped working and locked up artsd in kde, in 2.6.5 worked again but the
sound is very poor with a background noise and very, very poor to use with
xmame and artsd as I used to do. I have an ens1371 SB and I worked fine
with winxp and alsa, now it just works fine with winxp (no hardware
problem I guess). In kernel 2.6.5 I tried to use the latest version
available and installed alsa 1.0.4-r1 from gentoo's ebuild and the problem
is still there.
======================================================================

----------------------------------------------------------------------
 jdthood - 04-01-05 22:50 
----------------------------------------------------------------------
Submitter: Has there been any improvement in later ALSA releases?

----------------------------------------------------------------------
 rlrevell - 12-30-05 05:13 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-11-04 19:55 mbribeiro      New Issue                                    
04-11-04 19:55 mbribeiro      Distribution              => gentoo-linux    
04-11-04 19:55 mbribeiro      Kernel Version            => 2.6.5           
04-01-05 22:50 jdthood        Note Added: 0004291                          
12-30-05 05:13 rlrevell       Status                   new => closed       
12-30-05 05:13 rlrevell       Note Added: 0007236                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

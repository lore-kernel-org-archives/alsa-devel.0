From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001307]: cs46xx module load error with kernel 2.6.13-rc5
Date: Fri, 30 Dec 2005 23:30:49 +0100
Message-ID: <a3f7e5036818fdf2f687f1c21a6632f0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 02497154
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 23:30:49 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1307> 
======================================================================
Reported By:                jfeise
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1307
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Slackware 10.1
Kernel Version:             2.6.13-rc5
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             08-03-2005 18:25 CEST
Last Modified:              12-30-2005 23:30 CET
======================================================================
Summary:                    cs46xx module load error with kernel 2.6.13-rc5
Description: 
Using Slackware 10.1 with kernel 2.6.13-rc5, the cs46xx module is not
loaded and reports lots of unknown symbols in dmesg. See the attached file
with the dmesg output.
I am using ALSA 1.0.9a.
On the same machine, using kernel 2.6.10, everything works.

======================================================================

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:30 
----------------------------------------------------------------------
Local issue

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-03-05 18:25 jfeise         New Issue                                    
08-03-05 18:25 jfeise         File Added: cs46xx.out                       
08-03-05 18:25 jfeise         Distribution              => Slackware 10.1  
08-03-05 18:25 jfeise         Kernel Version            => 2.6.13-rc5      
12-30-05 23:30 rlrevell       Status                   new => closed       
12-30-05 23:30 rlrevell       Note Added: 0007290                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

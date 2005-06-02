From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001132]: Realtek ALC260, snd-hda-intel, 2.4.21-32, catastrophic CrAsH
Date: Thu, 2 Jun 2005 12:03:47 +0200
Message-ID: <766f502531fabb2641007476c4480432@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E4B0C19A
	for <alsa-devel@alsa-project.org>; Thu,  2 Jun 2005 12:03:47 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1132> 
======================================================================
Reported By:                speedking
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1132
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Distribution:               RHEL 3 U5 gold
Kernel Version:             2.4.21-32
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-28-2005 02:02 CEST
Last Modified:              06-02-2005 12:03 CEST
======================================================================
Summary:                    Realtek ALC260, snd-hda-intel, 2.4.21-32,
catastrophic CrAsH
Description: 
system hangs when either 'alsaconf' runs or you attempt a 'modprobe
snd-hda-intel'

System is a HP xw4300 workstation, Intel based, running an Azalia
compliant" "Intel High definition Audio" Realtek ALC 260 chip onboard.




======================================================================

----------------------------------------------------------------------
 speedking - 06-02-05 00:54 
----------------------------------------------------------------------
tiwai,

I have a proposal for you.  How do I contact you in person?  Please send
me an email to my account email address....should you have access to it.

Thanks...

----------------------------------------------------------------------
 tiwai - 06-02-05 12:03 
----------------------------------------------------------------------
You're reporting another problem.  Please open another bug.

The silent CD is a known problem, and I have no idea yet.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-28-05 02:02 speedking      New Issue                                    
05-28-05 02:02 speedking      Distribution              => RHEL 3 U5 gold  
05-28-05 02:02 speedking      Kernel Version            => 2.4.21-32       
05-31-05 12:58 tiwai          Status                   assigned => resolved
05-31-05 12:58 tiwai          Resolution               open => fixed       
05-31-05 12:58 tiwai          Note Added: 0004825                          
05-31-05 19:10 speedking      Status                   resolved => feedback
05-31-05 19:10 speedking      Resolution               fixed => reopened   
05-31-05 19:10 speedking      Note Added: 0004848                          
05-31-05 19:11 speedking      Note Edited: 0004848                         
05-31-05 19:14 speedking      Note Edited: 0004848                         
05-31-05 19:15 tiwai          Note Added: 0004849                          
05-31-05 19:23 speedking      Note Added: 0004850                          
05-31-05 19:26 speedking      Note Edited: 0004850                         
05-31-05 19:26 tiwai          Note Added: 0004851                          
05-31-05 19:44 speedking      Note Added: 0004852                          
05-31-05 19:51 tiwai          Note Added: 0004853                          
05-31-05 20:11 speedking      Note Added: 0004854                          
05-31-05 22:43 speedking      Note Added: 0004856                          
05-31-05 22:46 speedking      Note Edited: 0004856                         
06-02-05 00:27 speedking      Note Added: 0004872                          
06-02-05 00:54 speedking      Note Added: 0004873                          
06-02-05 12:03 tiwai          Status                   feedback => resolved
06-02-05 12:03 tiwai          Resolution               reopened => fixed   
06-02-05 12:03 tiwai          Note Added: 0004876                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005

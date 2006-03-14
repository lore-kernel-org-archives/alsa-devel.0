From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001632]: suse 10.0,  yast, no ad1986a listed,  in your soundcard list,  NO AD1986A  listed,.... asus, nothing,....
Date: Tue, 14 Mar 2006 15:01:04 +0100
Message-ID: <83f51dd6370432df1316e803a0390c12@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6CB301BB
	for <alsa-devel@alsa-project.org>; Tue, 14 Mar 2006 15:01:04 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1632> 
======================================================================
Reported By:                rsrtfm
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1632
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               suse 10.0, super, opensuse
Kernel Version:             2.6.13
======================================================================
Date Submitted:             12-10-2005 04:29 CET
Last Modified:              03-14-2006 15:01 CET
======================================================================
Summary:                    suse 10.0,  yast, no ad1986a listed,  in your
soundcard list,  NO AD1986A  listed,.... asus, nothing,....
Description: 
suse 10.0,  yast, no ad1986a listed,  in your soundcard list,  NO AD1986A 
listed,.... asus, nothing,....

plus,  nic, needs nforce , nvidia driver,  chipset supposed to do sound
and nic,... but on asus board a8n-vm csm ,  6150, 430,....

anyway , should , list the ad1986a, and be able to select it.

so far I have no sound!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! it's been 4 weeks.
ehm,...what did you say,.. I can't hear anything,....
where do I donate , my money, and anger?
thanks, Robert Schultz
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001793 No sound on ASUS A8N-VM CSM
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-13-06 17:57 
----------------------------------------------------------------------
There is no "AD1986A" driver, it's supported by the snd-hda-intel driver.

----------------------------------------------------------------------
 tiwai - 03-14-06 15:01 
----------------------------------------------------------------------
Use ALSA 1.0.11rc3, or better CVS version.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-10-05 04:29 rsrtfm         New Issue                                    
12-10-05 04:29 rsrtfm         Distribution              => suse 10.0, super,
opensuse
12-10-05 04:29 rsrtfm         Kernel Version            => 2.6.13          
12-12-05 04:59 juliancola     Note Added: 0006982                          
02-04-06 02:15 rbenech        Issue Monitored: rbenech                     
02-04-06 02:19 rbenech        Note Added: 0007907                          
02-04-06 02:22 rbenech        Note Added: 0007908                          
02-07-06 00:47 gerick         Issue Monitored: gerick                      
02-08-06 13:12 simonckenyon   Issue Monitored: simonckenyon                    
02-13-06 14:13 ukrcald        Note Added: 0008049                          
02-13-06 22:28 ukrcald        Note Deleted: 0008049                        
03-07-06 03:13 iaw4           Issue Monitored: iaw4                        
03-13-06 17:39 rlrevell       Relationship added       has duplicate 0001793
03-13-06 17:57 rlrevell       Note Added: 0008453                          
03-14-06 15:01 tiwai          Note Added: 0008476                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642

From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000971]: Compilation Errors - Cannot find specific files during compilation
Date: Fri, 18 Mar 2005 18:25:28 +0100
Message-ID: <f45a48b60a5ffd08bd296b2f77fe4020@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7EAE8243
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2005 18:25:28 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=971> 
======================================================================
Reported By:                rbechard1
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   971
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             03-08-2005 01:50 CET
Last Modified:              03-18-2005 18:25 CET
======================================================================
Summary:                    Compilation Errors - Cannot find specific files
during compilation
Description: 
When installing the application using the method described in this link:

http://www.alsa-project.org/alsa-doc/doc-php/template.php?company=Creative+Labs&card=Sound+Blaster+PCI+X+%28Dell+OEM%29.&chip=SB0200&module=emu10k1x

I get error messages during the compilation, yet the process tells me it
has completed successfully. When I go to configure my sound card it has
the correct driver loaded but yet there is no sound. When I checked the
mixer settings nothing is muted. 

There is no option within the sound configuration panel to switch to the
correct driver.
======================================================================

----------------------------------------------------------------------
 rbechard1 - 03-14-05 21:44 
----------------------------------------------------------------------
I recently found the new alsa 1.0.8 RPM packages for Mandrake 10.2 and
installed them with RPMDRAKE. This resolved this problem. It was much
easier as your src code continues to give be problems. I no longer need
help as this issue has now been resolved.

I 'strongly" suggest that your webmaster should put the RPM packages on
your website for the various distributions, it would save your support
people alot of time!!!!!!!!!!!!!!!!!

----------------------------------------------------------------------
 tiwai - 03-18-05 18:25 
----------------------------------------------------------------------
Then let's close this one.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-08-05 01:50 rbechard1      New Issue                                    
03-08-05 01:51 rbechard1      Issue Monitored: rbechard1                    
03-08-05 09:52 rbechard1      Note Added: 0003812                          
03-09-05 02:10 fmoraes        Note Added: 0003819                          
03-09-05 03:32 rbechard1      Note Added: 0003825                          
03-09-05 07:12 rbechard1      File Added: Driver 1.0.8 installation output      
             
03-14-05 21:41 rbechard1      Note Added: 0003906                          
03-14-05 21:44 rbechard1      Issue Monitored: fmoraes                     
03-14-05 21:44 rbechard1      Note Added: 0003907                          
03-14-05 21:47 rbechard1      Issue End Monitor: rbechard1                    
03-18-05 18:25 tiwai          Status                   assigned => resolved
03-18-05 18:25 tiwai          Resolution               open => unable to
duplicate
03-18-05 18:25 tiwai          Note Added: 0004004                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

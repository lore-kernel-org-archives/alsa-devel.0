From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000668]: AC3 passthrough works up to 2.6.10-rc1 but not under rc2
Date: Tue, 31 May 2005 18:04:59 +0200
Message-ID: <e14d96953f392b97bf76901c1047505f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 954661CA
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:04:59 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=668> 
======================================================================
Reported By:                Gregoire
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   668
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               gentoo amd64
Kernel Version:             2.6.10-rc2
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-23-2004 16:04 CET
Last Modified:              05-31-2005 18:04 CEST
======================================================================
Summary:                    AC3 passthrough works up to 2.6.10-rc1 but not under
rc2
Description: 
I have checked the changelog but I don't know what exactly have changed to
see which change breake the AC3 passtrough ?
======================================================================

----------------------------------------------------------------------
 Gregoire - 03-23-05 17:17 
----------------------------------------------------------------------
Sorry, as it worked since post 2.6.10-rc2 kernels, I thought you fixed this
issue.
I use now 2.6.12-rc1 and it works perfectly, would it help if I do what
you want with older kernels ?

----------------------------------------------------------------------
 jdthood - 03-23-05 17:21 
----------------------------------------------------------------------
Just checking to make sure that the problem is indeed fixed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-23-04 16:04 Gregoire       New Issue                                    
11-23-04 16:04 Gregoire       Distribution              => gentoo amd64    
11-23-04 16:04 Gregoire       Kernel Version            => 2.6.10-rc2      
11-23-04 16:08 tiwai          Note Added: 0002518                          
03-23-05 15:23 jdthood        Note Added: 0004158                          
03-23-05 17:17 Gregoire       Note Added: 0004179                          
03-23-05 17:21 jdthood        Note Added: 0004180                          
03-23-05 17:21 jdthood        Status                   new => resolved     
03-23-05 17:21 jdthood        Resolution               open => fixed       
03-24-05 21:42 Ariel          Issue Monitored: Ariel                       
05-31-05 18:04 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005

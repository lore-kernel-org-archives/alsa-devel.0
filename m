From: noreply@alsa-project.org
Subject: [ALSA - driver 0000143]: Kernel Oops
Date: Fri, 16 Jul 2004 13:05:27 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716110527.68A2526008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C4C0A255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 13:05:27 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000143
======================================================================
Reported By:                subodh
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     143
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.5-rc1
======================================================================
Date Submitted:             03-18-2004 00:55 CET
Last Modified:              07-16-2004 13:05 CEST
======================================================================
Summary:                    Kernel Oops
Description: 
When ever i compile something on my box i get a Oops
======================================================================

----------------------------------------------------------------------
 perex - 03-23-2004 15:57 CET 
----------------------------------------------------------------------
It does not look like ALSA bug. It looks like memory corruption.
Ask on the Linux kernel mailing list.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-18-04 00:55 subodh         New Bug                                      
03-18-04 00:55 subodh         File Added: oops.out                         
03-18-04 00:55 subodh         Distribution              => Gentoo          
03-18-04 00:55 subodh         Kernel Version            => 2.6.5-rc1       
03-18-04 00:56 subodh         File Added: lspci.out                        
03-18-04 00:56 subodh         File Added: dmesg.out                        
03-18-04 00:57 subodh         File Added: .config                          
03-18-04 00:57 subodh         File Added: ksymoops.txt                     
03-23-04 15:57 perex          Bugnote Added: 0000662                       
03-23-04 15:57 perex          Assigned To               => perex           
03-23-04 15:57 perex          Resolution               open => not a bug   
03-23-04 15:57 perex          Status                   new => resolved     
07-16-04 13:05 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click

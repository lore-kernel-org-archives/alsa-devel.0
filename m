From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000656]: ICE1712 and multiple cards clock sync
Date: Fri, 19 Nov 2004 09:41:32 +0100
Message-ID: <2768bb8d31b4288664713e15c939610f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 33DDE20F
	for <alsa-devel@alsa-project.org>; Fri, 19 Nov 2004 09:41:32 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=656> 
======================================================================
Reported By:                Michele Spinolo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   656
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 1
Kernel Version:             2.4.26
======================================================================
Date Submitted:             11-19-2004 09:41 CET
Last Modified:              11-19-2004 09:41 CET
======================================================================
Summary:                    ICE1712 and multiple cards clock sync
Description: 
I have set up my PC with 3 Terratec EWS88D cards, based on ICE1712 chip.

They offer the chance to be synched one to each other, defining a master
one
and using an internal connector to send the clock signal.

The problem is that using both envy24control or alsa control panel there
is
no option releated to this feature, so multiple boards clock sync is
impossible to be used.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-19-04 09:41 Michele SpinoloNew Issue                                    
11-19-04 09:41 Michele SpinoloDistribution              => Fedora Core 1   
11-19-04 09:41 Michele SpinoloKernel Version            => 2.4.26          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8

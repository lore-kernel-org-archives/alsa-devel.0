From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000729]: arts error on boot: AudioSubSystem:handleIO:write failed
Date: Sun, 19 Dec 2004 11:50:53 +0100
Message-ID: <f7660ca7e78eb47b1041df44c181012a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8470D2A3
	for <alsa-devel@alsa-project.org>; Sun, 19 Dec 2004 11:50:53 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=729> 
======================================================================
Reported By:                jbailo
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   729
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Suse 9.1
Kernel Version:             2.6.5-7.11
======================================================================
Date Submitted:             12-19-2004 11:50 CET
Last Modified:              12-19-2004 11:50 CET
======================================================================
Summary:                    arts error on boot: AudioSubSystem:handleIO:write
failed
Description: 
On book, an arts error message alert appears:

AudioSubSystem:handleIO: write failed
len = 3760, can_write = 3762, errno=32 (Broken pipe)
This mightbe a sound hardware/driver specific problem (see aRts FAQ)


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-19-04 11:50 jbailo         New Issue                                    
12-19-04 11:50 jbailo         File Added: boot.msg                         
12-19-04 11:50 jbailo         Distribution              => Suse 9.1        
12-19-04 11:50 jbailo         Kernel Version            => 2.6.5-7.11      
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

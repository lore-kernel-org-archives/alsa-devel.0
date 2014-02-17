From: bobby <bseventynine@yahoo.com>
Subject: Re: Unsupported Valley View 'LPE' adapter?
Date: Mon, 17 Feb 2014 09:54:48 +0000 (UTC)
Message-ID: <loom.20140217T104754-228@post.gmane.org>
References: <1385840039.2566.12.camel@adam.happyassassin.net>
 <529A5C6A.70604@ladisch.de> <1385865517.2566.36.camel@adam.happyassassin.net>
 <20131202063216.GJ8834@intel.com>
 <1386035807.2566.145.camel@adam.happyassassin.net>
 <1388369981.15622.7.camel@adam.happyassassin.net>
 <1388370192.15622.8.camel@adam.happyassassin.net>
 <s5hwqiebsuo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E34E265015
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 11:15:05 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1WFLE8-00029l-6z
 for alsa-devel@alsa-project.org; Mon, 17 Feb 2014 11:15:04 +0100
Received: from 192.8.191.10 ([192.8.191.10])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 11:15:04 +0100
Received: from bseventynine by 192.8.191.10 with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 11:15:04 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



This is a pci device for which the driver is not yet available.
I went through the intel atom processor manual and found that it has 3 I2S 
ports, has its 
own DMA. The Soc is interfaced with LPE audio core via internal PCI bus. 
Did you guys hear anything from intel about the driver support. Any inputs 
would be of great help please

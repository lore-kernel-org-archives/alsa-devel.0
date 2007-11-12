From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: E-mu 1212M/1820M/1616M development
Date: Mon, 12 Nov 2007 22:35:49 +0000
Message-ID: <4738D545.3060800@superbug.co.uk>
References: <47376DE9.5000904@gmail.com> <47378776.6050403@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net
	[194.217.242.90])
	by alsa0.perex.cz (Postfix) with ESMTP id 673BC2451A
	for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2007 23:35:16 +0100 (CET)
In-Reply-To: <47378776.6050403@superbug.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@alsa-project.org, Ctirad Fertr <c.fertr@gmail.com>
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
>
>> 2. Non working S/PDIF (and probably ADAT, too) on 1616(M) microdock 
>> ports. I think tese ports uses different set of registers than PCI 
>> 1010 host card. Am I right?
>>   
> Correct, they are different. I will try to update the driver with some 
> details tomorrow.
Comments added into hg repository, in emu10k1.h
alsa changeset: 5529

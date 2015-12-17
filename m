From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: mixer controls not detected for class compliant
	USB	audio interface (RME Babyface Pro)
Date: Thu, 17 Dec 2015 15:08:21 +0100
Message-ID: <5672C1D5.4050001@ladisch.de>
References: <567242C1.8030307@gmx.com> <5672A829.5010106@ladisch.de>
 <5672B14A.2050406@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 454DD26047C
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2015 15:08:23 +0100 (CET)
Received: from [10.1.2.65] (unknown [94.101.37.4])
 by dehamd003.servertools24.de (Postfix) with ESMTPSA id 7B8CBF520081
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2015 15:08:21 +0100 (CET)
In-Reply-To: <5672B14A.2050406@gmx.com>
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

Be wrote:
> What does the "unit 2 not found" error indicate?

That there is an error in the descriptors.

It might be possible that this unit would define a mixer controls,
if it existed.


Regards,
Clemens

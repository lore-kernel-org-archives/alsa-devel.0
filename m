From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: mixer controls not detected for class compliant
	USB	audio interface (RME Babyface Pro)
Date: Thu, 17 Dec 2015 13:18:49 +0100
Message-ID: <5672A829.5010106@ladisch.de>
References: <567242C1.8030307@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id C22282654E8
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2015 13:18:49 +0100 (CET)
In-Reply-To: <567242C1.8030307@gmx.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Be <be.0@gmx.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Be wrote:
> the device's mixer controls are not detected by Linux.

There are no class-compliant mixer controls.

> the manufacturer's iPad mixer program can control its mixer and onboard DSP effects.

That must happens with vendor-specific commands.


Regards,
Clemens

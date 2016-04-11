From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Alsamixer: missing Speakers entry in analog
	output	choice (chipset AV200)
Date: Mon, 11 Apr 2016 15:34:18 +0200
Message-ID: <570BA7DA.8010602@ladisch.de>
References: <570785F9.3020402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id DF747265B3E
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2016 15:34:19 +0200 (CEST)
In-Reply-To: <570785F9.3020402@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Germano Massullo <germano.massullo@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Germano Massullo wrote:
> I have a Asus Xonar Essence ST soundboard
>
> Sometimes the Speakers output disappears from alsamixer.

>From alsamixer, or from PulseAudio?

> I attach 3 logs taken when the problem was occurring.

> Simple mixer control 'Analog Output',0
>   Capabilities: enum
>   Items: 'Speakers' 'Headphones' 'FP Headphones'

It's there.


Regards,
Clemens

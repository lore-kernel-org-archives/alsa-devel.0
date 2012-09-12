From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Channel map API patches: to be 3.7 or not to be?
Date: Wed, 12 Sep 2012 18:32:26 +0200
Message-ID: <5050B91A.7020303@ladisch.de>
References: <s5hk3w1g4e2.wl%tiwai@suse.de>
 <CAN8cciYtoH91sFjwes+aTAjO+4z8CCMdOYgM4kdWbGNr3iuheQ@mail.gmail.com>
 <s5hbohdezpc.wl%tiwai@suse.de> <s5hehm8rc2s.wl%tiwai@suse.de>
 <504F2C65.1090204@ladisch.de> <s5hbohcrbme.wl%tiwai@suse.de>
 <s5hbohb1b5e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 98808261722
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 18:32:28 +0200 (CEST)
In-Reply-To: <s5hbohb1b5e.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>> Clemens Ladisch wrote:
>>> Takashi Iwai wrote:
>>>>   is it useful to add SND_CHMAP_MONO, or is it just redundant?
>>>
>>> What would it be used for?
>
> Looking at PulseAudio and gstreamer codes, they seem to have explicit
> MONO channel definition.
> [...]
> So, defining MONO seems rather standard.  Now I'm inclined to define
> SND_CHMAP_MONO...

Okay; if they want it, they can get it ...


Regards,
Clemens

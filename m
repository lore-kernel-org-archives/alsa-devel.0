From: The Source <thesourcehim@gmail.com>
Subject: Re: OSS support
Date: Wed, 17 Jun 2009 12:05:36 +0400
Message-ID: <4A38A3D0.4080903@gmail.com>
References: <4A38957C.5030905@gmail.com> <s5h63ev47fq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id CB2322451E
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Jun 2009 10:03:34 +0200 (CEST)
Received: by bwz11 with SMTP id 11so121231bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2009 01:03:34 -0700 (PDT)
In-Reply-To: <s5h63ev47fq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 17.06.2009 11:59, Takashi Iwai wrote:
> At Wed, 17 Jun 2009 11:04:28 +0400,
> The Source wrote:
>    
>> Is oss emulation still supported in latest alsa-driver snapshot? I
>> installed that driver in Fedora 11 on both my static machine (X-Fi
>> platinum fatality champion) and laptop (HDA Intel) and I don't have
>> /dev/dsp or /dev/mixer. Should I compile the driver with some specific flag?
>>      
> Did you load snd-pcm-oss and snd-mixer-oss modules?
>
>
> Takashi
>
>    
Oh! I though they would be loaded automatically. Thanks!

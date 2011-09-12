From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: 3.1-rc5 is the worst
Date: Mon, 12 Sep 2011 11:05:38 +0200
Message-ID: <4E6DCB62.1070406@ladisch.de>
References: <CAC9WiBjoO50H5ZQEShbdZ=64ZXz6Q-OdD+VSD-YrBry3hvdJJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay01.ispgateway.de (smtprelay01.ispgateway.de
	[80.67.29.23]) by alsa0.perex.cz (Postfix) with ESMTP id CE426103827
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 11:05:21 +0200 (CEST)
In-Reply-To: <CAC9WiBjoO50H5ZQEShbdZ=64ZXz6Q-OdD+VSD-YrBry3hvdJJQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Francis Moreau <francis.moro@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

(CC to alsa-devel and Takashi)

Francis Moreau wrote:
> Maybe the subject sounds rude so apologize since I just want to report
> that 3.1-rc5 gives me bad impression.
> 
> 1/ I'm getting this now at each boot:
> 
>   [   38.349671] hda_codec: too deep connection for 0x18
>   [   38.349748] hda_codec: too deep connection for 0x18
>   [   38.349842] hda_codec: too deep connection for 0x18
>   [   38.349843] hda_codec: too deep connection for 0x18
>   [   38.349844] hda_codec: too deep connection for 0x18
>   [   38.349939] hda_codec: too deep connection for 0x18
>   <repeated 252 times>
> 
> I've no idea what it does mean or it's simply a warning I can ignore
> (and it that case it would be nice to limit it at least) or if it's
> worse getting a fix before 3.1 is out would be great.
> ...

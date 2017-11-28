From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: ALSA: nm256: Fine-tuning for three function
	implementations
Date: Tue, 28 Nov 2017 16:01:47 +0100
Message-ID: <a1cd0902-c8bb-9813-8d0c-d394975ef745@users.sourceforge.net>
References: <d98a2685-ddf9-1cba-839a-d12c5ff8d3ba@users.sourceforge.net>
 <dfa99045-f213-3dad-b1f4-2e90eb38ddbd@users.sourceforge.net>
 <s5h7euq9hqt.wl-tiwai@suse.de>
 <24f8c777-1eb4-e7e7-9371-79f32700c9dc@users.sourceforge.net>
 <s5hbmjmluba.wl-tiwai@suse.de>
 <2cbef557-5f89-c630-e108-14ef2ce6b41a@users.sourceforge.net>
 <s5h4lpelqfm.wl-tiwai@suse.de>
 <1547a4c2-5b70-e3a3-b482-d28c538e615c@users.sourceforge.net>
 <s5hy3mqr5v9.wl-tiwai@suse.de>
 <c2b7543c-cd2c-f7f6-98f3-23e2ca6f8b90@users.sourceforge.net>
 <s5hshcyr2on.wl-tiwai@suse.de>
 <539adde3-a713-721f-2a0d-1d1ef925fb86@users.sourceforge.net>
 <s5hpo82r1s5.wl-tiwai@suse.de>
 <9a9348f4-d059-de28-1445-0189b7fb0ba3@users.sourceforge.net>
 <s5hlgiqr0ad.wl-tiwai@suse.de>
 <3b7b24bd-4bdf-752e-1a62-cc71e9152acc@users.sourceforge.net>
 <s5hbmjmqxzs.wl-tiwai@suse.de>
 <bafa4437-2aaf-245d-da60-2353ca5debab@users.sourceforge.net>
 <s5h8teqqxhx.wl-tiwai@suse.de>
 <f7189a7c-3b07-e976-ac18-6143365bbd21@users.sourceforge.net>
 <s5h7euaqwtp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 942A3266B0F
 for <alsa-devel@alsa-project.org>; Tue, 28 Nov 2017 16:01:54 +0100 (CET)
In-Reply-To: <s5h7euaqwtp.wl-tiwai@suse.de>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

>>> Give the test result before speaking too much.
>>
>> Which concrete data do you expect here?
> 
> Depends on the result.

How can this vary?


> The bottom line is that you run your patched kernel on the real hardware

Which test configurations would you trust finally?


> or equivalent (VM or emulation) for the device you touched.

Can all the devices for which I dared to adjust their source code a bit
tested in desired ways within virtual machines?


> Run your patched kernel and the driver code on the real machine with
> the corresponding device.  Show the device is running.  That's the
> very first step.  Then follow the more detailed tests, but it depends
> on the subsystem.

How can such descriptions improve the trust situation?

Regards,
Markus

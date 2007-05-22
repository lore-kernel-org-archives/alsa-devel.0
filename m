From: Matthias Koenig <mkoenig@suse.de>
Subject: Re: [PATCH] remove email addresses from MODULE_AUTHOR
	tag
Date: Tue, 22 May 2007 11:54:18 +0200
Message-ID: <n7xwsz1w5dh.fsf@sor.suse.de>
References: <4643C20C.8050105@gmail.com> <s5hd517ich2.wl%tiwai@suse.de>
	<4644DC5A.7060905@gmail.com> <4645F2F4.2010807@gmail.com>
	<464E54FF.7080207@gmail.com> <s5hd50wev91.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E2F2243AA
	for <alsa-devel@alsa-project.org>;
	Tue, 22 May 2007 11:54:08 +0200 (CEST)
In-Reply-To: <s5hd50wev91.wl%tiwai@suse.de> (Takashi Iwai's message of "Sat,
	19 May 2007 16:35:54 +0200")
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
Cc: ALSA devel <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@suse.cz>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> At Sat, 19 May 2007 03:38:07 +0200,
> Rene Herman wrote:
>> 
>> On 05/12/2007 07:01 PM, Rene Herman wrote:
>> 
>> > On 05/11/2007 11:12 PM, Rene Herman wrote:
>> > 
>> >> I seem unlikely to convince him but I believe it's upto specific 
>> >> subsystems whether or not they'll take patches removing the email 
>> >> adresses from the tag, ie, in the case of ALSA upto you and Jaroslav.
>> > 
>> > For what it's worth, Linus merged the patch removing the advice to 
>> > include an email address in the MODULE_AUTHOR comment:
>> > 
>> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=108f39a1b3b1e4b28ca8cc156f06171445499d21 
>> > 
>> > 
>> > He was aware of Alan's objection. Removing existing ones is ofcourse not 
>> > quite the same as not introducing new ones though so ofcourse still up 
>> > to you. I'm still signing off on it...
>> 
>> Takashi, Jaroslav, could you get me an ACK or NAK on this? I'm waiting 
>> around before submitting more to see if you'll take 'em.
>
> Well, I myself don't mind to remove my address at all, but IMO, it's a
> thing that needs approval by each author (although we are allowed to 
> do it without asking, of course).
>

Ok, approval from my side (mts64).

Matthias

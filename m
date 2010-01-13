From: Josh Lehan <alsa@krellan.com>
Subject: Re: Newbie question: Sending untimed MIDI data to ALSA
 seq
Date: Wed, 13 Jan 2010 11:17:02 -0800
Message-ID: <4B4E1C2E.1010209@krellan.com>
References: <4B490D93.1050506@krellan.com> <s5hpr5f64cl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server3.hostdango.com (server3.hostdango.com [67.222.146.219])
	by alsa0.perex.cz (Postfix) with ESMTP id C026410382A
	for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2010 20:17:28 +0100 (CET)
In-Reply-To: <s5hpr5f64cl.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Josh Lehan <alsa@krellan.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Sat, 09 Jan 2010 15:13:23 -0800,
> Josh Lehan wrote:
>> Hello.
>>
>> Newbie question: I'm wondering about sending untimed MIDI data to the
>> ALSA sequencer subsystem.
>>
>> The application would be for a "beep"-like program, from the command
>> line, that instead of making beeps, would play MIDI instruments to make
>> better-sounding beeps.
>>
>> Does such a program already exist?
> 
> I don't know of such thing, too.
> It'd be nice to have in alsa-utils.

Thanks for the suggestion!

A few days ago, I started writing a program to do just this.  It is
coming along nicely.  When it's finished, I'll post a link to it here,
for your review.

Josh

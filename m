From: "Bjoern Olausson" <lkmlist@gmail.com>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Fri, 17 Oct 2008 17:33:33 +0200
Message-ID: <5501535d0810170833y9c70e39q9eb685c4ea29f3d4@mail.gmail.com>
References: <s5hy70xsl46.wl%tiwai@suse.de> <48F7855F.6060806@gmail.com>
	<s5hbpxj6902.wl%tiwai@suse.de> <48F83013.4060203@gmail.com>
	<s5h7i8767zu.wl%tiwai@suse.de> <48F8542E.30702@nostalgicnetworxx.org>
	<s5hwsg7zib3.wl%tiwai@suse.de>
	<48F85FE3.4060704@nostalgicnetworxx.org>
	<1224237619.4011.8.camel@localhost>
	<48F86A8C.6020309@nostalgicnetworxx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.247])
	by alsa0.perex.cz (Postfix) with ESMTP id F2764243E6
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Oct 2008 17:33:51 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so520120rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2008 08:33:33 -0700 (PDT)
In-Reply-To: <48F86A8C.6020309@nostalgicnetworxx.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 17, 2008 at 12:35 PM, Xarteras
<xarteras@nostalgicnetworxx.org> wrote:
> Tony Vroon wrote:
>> On Fri, 2008-10-17 at 09:50 +0000, Xarteras wrote:
>>> ossplay still crashes though and strace isn't of much use.
>>> Running ossplay causes a sys reset so fast the strace output cannot even
>>> be flushed to disk anymore, neverless be up long enough to read it on
>>> the screen.
>>
>> A serial console may help you there, assuming you have two machines.
>
> Good idea :)
>
> Just tried it, but even a 115200 baud serial connection isn't fast
> enough to give me more than the first three lines of useless strace
> output before it's back to BIOS.
>
> Jan Wolf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

Same here, not with serial, not with ssh, not even with a Camera
recording the screen....

No logs either...

By the way,
-amarok with xine as backand using ALSA works
-Flash movies with sound in Opera work
-Xine works flawless (nice sound)...just watched "Big_bug_bunny_080p stereo.ogg"

Now I am listening to my favourite song Diana_Krall_-_Black_Crow.mp3
(256kbps 44100Hz) with xine.
Clear, distortionfree, lovely sound!

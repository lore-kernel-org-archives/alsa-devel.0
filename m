From: "Klaus Schulz" <kls.schlz@googlemail.com>
Subject: Re: HP Pavillion TX2000z - Headphonejack not working
Date: Thu, 11 Dec 2008 18:55:05 +0100
Message-ID: <d9690f190812110955ja3d0ca2qa90efdd58a0ca168@mail.gmail.com>
References: <d9690f190812110907w7fe7c0d4w4a71b4e0c36f3300@mail.gmail.com>
	<49414D6B.8090402@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.153])
	by alsa0.perex.cz (Postfix) with ESMTP id EAA872462F
	for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2008 18:55:06 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 9so484692ywk.2
	for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2008 09:55:05 -0800 (PST)
In-Reply-To: <49414D6B.8090402@cox.net>
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
To: stan <ghjeold_i_mwee@cox.net>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Stan.

You don't seriously expect me to show this document to a standard Linux
User!!
This is designer talk!
The normal user needs a manageable guideline.

Is there a(n) (up2date and reliable!!) database of Codecs, PCs and its
interface implementations and testrecords
somewhere?  Let me know there is one.

My role: I am just gathering the problems over there
http://ubuntuforums.org/showthread.php?t=962695
I am making sure that the mixer issue is clarified over there at
Ubuntuforums as well
as the model-id part. Beyond that everything else will exceed my capacities.

The model-id part, if you read Takashi's document, sounds IMO pretty fluffy.

You can't expect a user to try all model-ids, to find the right one.
You need to set up a database for that. Expecting the normal user to fiddle
around
with module options, is also not what I'd honestly expect from a 2009 Linux
sound layer.

Sorry for sounding maybe a bit harsh. But the issues of "My headphone jack
is not working" "My speakers are not working"
"I got noise on my speakers" "I can't use my digital out" asf asf somehow
have to get under control.
It is obvious that a normal user can not handle this.

A reliable, well maintained database and  user documentation would be a IMO
a nice starting point.

THX
Klaus

On Thu, Dec 11, 2008 at 6:27 PM, stan <ghjeold_i_mwee@cox.net> wrote:

> Klaus Schulz wrote:
>
>> Hi folks.
>>
>> Another problem now with HP and realtek AC861VD.
>>
>> The headphone-jack is not working.
>>
>> Known issue?
>>
>>
> You might be interested in the links in the email from Takashi Iwai copied
> below.  They describe the troubleshooting of HD Audio devices.
>
>
> Hi,
>
> per popular demand, I wrote a brief document more about HD-audio driver.
> It's now found in sound git tree as Documentation/sound/alsa/HD-Audio.txt.
> The git tree is:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
>
> You can get the text from web:
>
>
> http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=blob_plain;f=Documentation/sound/alsa/HD-Audio.txt;hb=HEAD
>
> A PDF file is found at:
>
> http://ftp.kernel.org/pub/linux/kernel/people/tiwai/docs/HD-Audio.pdf
>
> Comments, corrections and additions are appreciated.
>
> thanks,
>
> Takashi
>
>>
>>

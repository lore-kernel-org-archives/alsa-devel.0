From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: I would like to help with ALC 655
Date: Tue, 28 Oct 2003 15:33:33 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F9E8C4D.70400@superbug.demon.co.uk>
References: <3f9e61c83ba82@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3f9e61c83ba82@wp.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?windows-1252?Q?=22Pawe=3F_R=F3z=2Ean=27ski_=28z_WWW=29=22?= <tokugawa@wp.pl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Pawe? Róz.an'ski (z WWW) wrote:
> Hello
>   I will have GA-7VT600. So.. it will be VIA 8235(8237) with
> Realtek ALC 655.
>   As I read alsa-devel archive (and ac97_codec.c) 650 is
> supported but 655 is not. 
>   Is that true ?
> 
>   I would like to help develop driver for it. I have both spec
> from realtek website,
>   but I don't know where to start coding. (only in ac97_codec.c ?)
> 
>   James Courtier-Dutton wrote (in thread about ALC 655) that 
>      "If you get the motherboard, I could work with you to get it
> working."
> 
>   It would be nice if he or any other developer will help me with
> that.
> 
> thx for any info,
> Pawel Rozanski
> 

ALC655 should work already. It is so similar to the ALC650, that we 
treat them both the same. If you find something that does not work, we 
can look into it. Realtek are helpful and publish all their datasheets, 
VIA are not so helpful, and I don't have datasheets, but other people 
who have signed NDAs might have the datasheets.

Cheers
James



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

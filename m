From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: hdsp driver and tools update
Date: Mon, 3 Nov 2003 14:39:19 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045.217.184.8.24.1067866759.squirrel@www.undata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> At Sat, 1 Nov 2003 12:19:52 +0100 (CET),
> Thomas Charbonnel wrote:
>>
>> Hi,
>>
>> I apologize for having been so silent the last few weeks, I was in the
process of moving from Lyon, France to Berlin, Germany. This is now
done, and I resumed my work on the hdsp driver and tools.
>> Latest patches and tools can be found here :
>> http://www.undata.org/~thomas/
>> Mojor changes include support for hdsp 9632 cards and bugfixes for hdsp
9652 cards.
>> Hdspconf and hdspmixer now support 96xx cards, though this needs
testing as I do not have the hardware.
>
> thanks, i'll try to merge later.
> is the patch against to cvs or 0.9.8?
>

It's against cvs from a few days. The only differences with 0.9.8 were 1
liners IIRC, so the patch should apply to both, I think.

>> Takashi, I noticed that though it's been in cvs for some time now,
hdspconf is still not included in alsa-tools releases, is there a
reason for this ?
>
> it was mistakenly not included in the tarball.
> this should have been fixed.
>

Thanks !

Thomas





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

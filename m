From: Eric Klein <eklein@ait.nrl.navy.mil>
Subject: Re: Audigy LS SPDIF output.
Date: Mon, 21 Jun 2004 16:34:04 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40D7463C.5090406@ait.nrl.navy.mil>
References: <40D72EBF.80108@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40D72EBF.80108@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:

> Hi,
>
> I cannot test SPDIF output because I cannot find a suitable 4 pole 
> mini jack that has 3 phone plugs on the end of it, so that I can test 
> spdif out.
>
> I have tried a few different cables, but none of them even work with 
> the 4front drivers. Once I have a cable that works with the 4Front 
> drivers, I will then look into getting the ALSA driver working.
>
> Can anybody help me here?

There are two solutions I can offer (assuming when you mention phone 
plugs, that you mean 3-pole 3.5mm plugs):
1) Creative UK offers a set of cables that will take the 3 output lines 
(two of which are 4-pole lines) and convert them into 4 3-pole lines 
(aka stereo lines). These cables are meant for hooking the Audigy 2 up 
to a set of creative labs 7.1 speakers. The website to order the cable 
is: http://uk.europe.creative.com/estore/product.asp?prod=598   . I'm 
not sure why they don't offer this cable in the US, but I assume you can 
order if from the UK.
2) You can make a custom cable (this is what I spent my day doing 
today). You can buy a camcorder cable which has a 4-pole 3.5mm plug on 
one end, and 3 mono RCA type plugs. If you then buy some mono-phone 
plugs (either 3.5mm (aka 1/8") or 1/4" will do), you can cut off the RCA 
plugs and do a little wire splicing/soldering to attach the plugs you 
want. This solution works very nicely (although it takes a little time).

Good luck,

Eric Klein
eklein@ait.nrl.navy.mil


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com

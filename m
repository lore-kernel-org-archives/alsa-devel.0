From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Is there plans to support SiS7019?
Date: Thu, 19 Aug 2004 17:26:59 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1092950819.830.18.camel@krustophenia.net>
References: <34863.192.168.0.10.1092904274.squirrel@dev.datamax.co.in>
	 <Pine.HPX.4.33n.0408191306530.11486-100000@studcom.urz.uni-halle.de>
	 <2903.192.168.0.30.1092922626.squirrel@dev.datamax.co.in>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <2903.192.168.0.30.1092922626.squirrel@dev.datamax.co.in>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Vrihad Shoonya <vrihad@softhome.net>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2004-08-19 at 09:37, Vrihad Shoonya wrote:
> > It might help if we can take a look at the source.
> >
> > Google finds a NetBSD patch at
> > <http://www.yasuoka.net/~yasuoka/sis7019.html>, so it's possible.
> 
> I can provide the source if you need it. But again it is for OSS
> not alsa.
> 
> I want to find out how much time is needed to make the
> driver from scratch if hardware specs are available. I have
> no prior experience on this.
> 

Google for "Writing an ALSA driver".  This excellent document by Takashi
Iwai gives step by step instructions with many examples from the real
code.  This should give you a pretty good idea of how long writing a
driver takes, given the specs.

I would imagine source code for an OSS driver would be even better than
having the docs, as long as the code is not obfuscated.

Lee



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285

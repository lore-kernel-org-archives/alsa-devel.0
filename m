From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: ALSA 1.0.13 + 2.6.19rc5 configuration/compilation
 error
Date: Sun, 19 Nov 2006 11:15:29 +0000
Message-ID: <45603CD1.2050500@superbug.co.uk>
References: <456038d70cf0a@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <456038d70cf0a@wp.pl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Krzysztof Helt wrote:
> Hello,
> 
> I tried to build an alsa 1.0.13 with kernel 2.6.19rc5 for ARM.
> 
> Configuration worked ok, but then compilation failed. I used
> these commands:
> 
> 
> I hope someone can point how to fix it (or fix it).
> Krzysztof
> 

I don't suppose you thought to read the "SUPPORTED_KERNELS" in the 
alsa-driver tree?


It states:
  - Vanilla 2.6.18 or earlier

James

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

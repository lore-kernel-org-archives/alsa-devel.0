From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: ASoC merge plans
Date: Mon, 29 Jan 2007 14:02:19 +0000
Message-ID: <1170079339.31420.30.camel@localhost.localdomain>
References: <20070129125837.GE12669@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20070129125837.GE12669@trinity.fluff.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Ben Dooks <ben@trinity.fluff.org>
Cc: "Graeme.Gregory" <Graeme.Gregory@wolfsonmicro.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Ben,

On Mon, 2007-01-29 at 12:58 +0000, Ben Dooks wrote:
> What is the current merge plans for getting ASoC
> into the kernel? is there any specific timeline?
> 

Were working hard atm trying to get 0.13 released and ready for the next
merge kernel window (0.12 is already in alsa-kernel). This will include
AT91xx and pxa2xx platform support and corgi, tosa, borzoi, poodle, HTC
magician and eti_b1 machine support.

> I am specifically interested in the S3C24xx series
> as this is what most of my current work is with.

S3C24xx platform support is pretty much working well now (probably could
do with a little more testing). Your patches made this quite easy :) I
think we should probably proceed and try for S3C24xx support 2.6.21.

Takashi, when do you and Jaroslav intend to push alsa-kernel in this
merge window. Do you have a date in mind that I can target for the next
release ?

Cheers

Liam   




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

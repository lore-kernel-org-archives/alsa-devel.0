From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Adding MSI RS482M4 motherboard to Intel HDA driver
Date: Mon, 12 Mar 2007 14:23:25 -0400
Message-ID: <75b66ecd0703121123k5f74026bk9d4e1cd09c491433@mail.gmail.com>
References: <e4fbff80703121116x2119bcccp829c9acd5c61f341@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <e4fbff80703121116x2119bcccp829c9acd5c61f341@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Stephen Hassard <steve@hassard.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 3/12/07, Stephen Hassard <steve@hassard.net> wrote:
> Hi there,
>
> I have an MSI RS482M4-ILD motherboard, using the ATI RS482 chipset and
> SB450 southbridge. Alsa version 1.0.14rc3 doesn't properly detect the
> on-board HDA. The motherboard is using the Realtek ALC880 chipset for
> audio.
>

I don't think this is enough information.

How exactly does it fail, and what "model" option (if any) makes it
work?  See Documentation/ALSA-Configuration.txt for a list of models
for ALC880.

Lee

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

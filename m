From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: TWL4030 Codec for OMAP
Date: Fri, 2 Mar 2007 17:24:47 -0500
Message-ID: <75b66ecd0703021424l69f3d830wdef138b4c53bd988@mail.gmail.com>
References: <1E65310C3C9FCC4AAE66BA8952B9842D09DBF5@dlee11.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1E65310C3C9FCC4AAE66BA8952B9842D09DBF5@dlee11.ent.ti.com>
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
To: "Martinez de la Cruz, Leonides" <leonides@ti.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 3/2/07, Martinez de la Cruz, Leonides <leonides@ti.com> wrote:
> I am currently working in porting a TWL4030 chip codec to use ALSA library.
> I am using alsa-lib-1.0.13 and alsa-utils-1.0.13, in a 2.6.14 kernel
> version. It seems the sound card is registered and also do the mixer
> controls. But when trying to access the specific information of one control,
> I get the following error:
>
> amixer: Control hw:0 element read error: Inappropriate ioctl for device

You forgot to include a link to your driver source code.

Lee

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: aoss [patch: /dev/sound, man page]
Date: Fri, 13 Aug 2004 14:11:39 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040813141139.673fcb8e@mango.fruits.de>
References: <20040805014457.49395908@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (pop.gmx.de [213.165.64.20])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 150A228C
	for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2004 14:01:18 +0200 (MEST)
In-Reply-To: <20040805014457.49395908@mango.fruits.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 5 Aug 2004 01:44:57 +0200
Florian Schmidt <mista.tapas@gmx.net> wrote:

> 
> The below patch [also attached] fixes the check for device files in
> /dev/sound/ [for users of devfs who have configured their apps to use
> /dev/sound/dsp, etc..] and  adds a note to the aoss manpage
> about the state of mmap support:
> 

Hi,

i wanted to ask if there's a reason for not including this patch in the
rc's?


Flo

-- 
Palimm Palimm!
http://affenbande.org/~tapas/



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285

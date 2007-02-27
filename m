From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Unable to poll() or select() with PCM capture
	device
Date: Tue, 27 Feb 2007 18:31:47 +0100
Message-ID: <1172597507.6807.1176802035@webmail.messagingengine.com>
References: <b6251a620702270520l63c5576sae91a31801e919e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <b6251a620702270520l63c5576sae91a31801e919e3@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Christophe Osuna <christophe.osuna@gmail.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Christophe Osuna wrote:
> I am trying to use select() on ALSA devices but it does not work. I
> must be missing something. Does anyone have an idea of what is wrong
> with my code?

Did you start the device, or did you configure it to start automatically?


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

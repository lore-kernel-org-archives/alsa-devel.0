From: Justin Cormack <justin@street-vision.com>
Subject: Re: RME HDSP9652
Date: 27 Nov 2002 18:27:04 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1038421629.20379.19.camel@lotte>
References: <1038417705.3078.14.camel@lotte>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1038417705.3078.14.camel@lotte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: pbd@op.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2002-11-27 at 17:21, Justin Cormack wrote:
> 
> 
> I have just got a couple of the new RME Hammerfall HDSP9652 cards, and
> find that they are not supported by the snd-hdsp driver yet. The card is
> basically the same hardware as the other hdsp cards but with the io
> integrated on the card.
> 
> I would guess that it will need a different firmware and another type in
> HDSP_Type, plus the channel info.  Does anyone know how to get the
> formware from RME (who to contact)?

I just found the earlier message saying "It should work" ex the mixer.
Well, it doesnt seem to, but which driver should work, the hdsp driver
or rme9652?




-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en

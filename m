From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.12-rc1-mm2
Date: Thu, 26 May 2005 15:58:21 +0200
Message-ID: <200505261558.22267.rjw@sisk.pl>
References: <20050324044114.5aa5b166.akpm@osdl.org> <200503242331.46985.rjw@sisk.pl> <20050525172949.0d5e637c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050525172949.0d5e637c.akpm@osdl.org>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, rlrevell@joe-job.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thursday, 26 of May 2005 02:29, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > 
> > BTW, on 2.6.12-rc1-mm2 I can't rmmod the snd_intel8x0 module (the process
> > goes into the D state immediately), which did not happen before.  This is 100%
> > reproducible, on two different AMD64-based boxes, with different sound chips.
> 
> Is this bug stil present in 2.6.12-rc5-mm1 or 2.6.12-rc5?

It's gone. :-)

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005

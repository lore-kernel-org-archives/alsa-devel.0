From: Michal Jaegermann <michal@ellpspace.math.ualberta.ca>
Subject: Re: General protection fault when unloading
	snd_hda_intel on	2.6.30-rc1+
Date: Sat, 11 Apr 2009 18:33:20 -0600
Message-ID: <20090412003320.GA17346__12913.6383570314$1239518220$gmane$org@ellpspace.math.ualberta.ca>
References: <20090411193630.GA16968@Pilar.aei.mpg.de>
	<20090411132033.003c581c@infradead.org>
	<20090411210336.GA15272@Pilar.aei.mpg.de>
	<20090411143950.3429ebc0@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20090411143950.3429ebc0@infradead.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, "Carlos R. Mafra" <crmafra2@gmail.com>, linux-kernel@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 11, 2009 at 02:39:50PM -0700, Arjan van de Ven wrote:
> 
> so... "dev" is pointing evbit at... 697665646632785 which looks like grabage.

FWIW 697665646632785c decodes in ASCII as "\x2fdevi".

   M.
